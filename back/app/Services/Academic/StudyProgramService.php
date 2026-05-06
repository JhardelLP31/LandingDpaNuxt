<?php
namespace App\Services\Academic;

use App\Models\Academic\StudyProgram;
use Illuminate\Support\Str;

class StudyProgramService
{
    public function createProgram(array $data, int $unitId): StudyProgram
    {
        $data['academic_unit_id'] = $unitId;
        $data['slug'] = $data['slug'] ?? Str::slug($data['name']);
        
        return StudyProgram::create($data);
    }
}