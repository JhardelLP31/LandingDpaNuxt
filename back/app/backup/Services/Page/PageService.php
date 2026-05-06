<?php

namespace App\Services\Page;

use App\Models\Page\Page;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;

class PageService
{
    public function storePage(array $data, $image = null)
    {
        return DB::transaction(function () use ($data, $image) {
            $data['slug'] = $data['slug'] ? Str::slug($data['slug']) : Str::slug($data['title']);
            $data['user_id'] = auth()->id() ?? 1;

            if ($image) {
                $data["featured_image_path"] = $image->store("pages", "public");
            }

            $page = Page::create($data);

            if (!empty($data['category_ids'])) {
                $page->categories()->sync($data['category_ids']);
            }

            return $page;
        });
    }

    

    public function updatePage(Page $page, array $data, $image = null)
    {
        return DB::transaction(function () use ($page, $data, $image) {
            if (isset($data['slug']) && $data['slug'] != $page->slug) {
                $data['slug'] = Str::slug($data['slug']);
            }

            if ($image) {
                if ($page->featured_image_path) {
                    Storage::disk('public')->delete($page->featured_image_path);
                }
                $data["featured_image_path"] = $image->store("pages", "public");
            }

            // Manejo de bloques JSON
            if (isset($data['content_blocks'])) {
                $blocks = $data['content_blocks'];
                $data['content_blocks'] = is_string($blocks) ? json_decode($blocks, true) : $blocks;
            }

            $page->update($data);

            if (isset($data['category_ids'])) {
                $page->categories()->sync($data['category_ids']);
            }

            return $page;
        });
    }
}