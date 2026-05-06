<?php

namespace App\Providers;

use App\Models\Lead\Lead;
use App\Models\Page\Page;
use App\Policies\PostPolicy;
use App\Policies\LeadPolicy; 
use App\Models\Course\Course;  
use App\Policies\CoursePolicy; 
use App\Models\Media\Media;     
use App\Models\Menu\MenuItem;   
use App\Policies\MediaPolicy;   
use App\Policies\MenuPolicy;    
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;
// IMPORTANTE: Añade esta línea
use Illuminate\Support\Facades\URL;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        if (config('app.env') === 'production' || env('FORCE_HTTPS', false)) {
            URL::forceScheme('https');
        }

        Gate::policy(Page::class, PostPolicy::class);
        Gate::policy(Course::class, CoursePolicy::class); 
        Gate::policy(MenuItem::class, MenuPolicy::class);
        Gate::policy(Media::class, MediaPolicy::class); 
        Gate::policy(Lead::class, LeadPolicy::class);

        // 2. SUPER ADMIN (Spatie)
        Gate::before(function ($user, $ability) {
            return $user->hasRole('Super-Admin') ? true : null;
        });
    }
}