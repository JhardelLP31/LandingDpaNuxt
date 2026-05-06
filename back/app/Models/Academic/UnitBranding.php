<?php
namespace App\Models\Academic;

use Illuminate\Database\Eloquent\Model;
use App\Models\Media\Media;
// 👇 Asegúrate de importar tu modelo Menu (Ajusta la ruta si es diferente)
use App\Models\Common\Menu; 

class UnitBranding extends Model
{
    protected $table = 'unit_branding';
    
    // 👇 Solo los campos reales que sí existen en tu base de datos
    protected $fillable = [
        'academic_unit_id', 'primary_color', 'secondary_color', 'accent_color',
        'logo_primary_id', 'logo_footer_id', 'favicon_id', 
        'header_config', 'footer_config', 'custom_css' // <-- Aquí vivirá toda tu magia
    ];

    protected $casts = [
        'header_config' => 'array',
        'footer_config' => 'array',
        // Si quieres, puedes añadir 'custom_css' => 'array' en el futuro para que Laravel lo parsee automático
    ];

    public function logoPrimary() { return $this->belongsTo(Media::class, 'logo_primary_id'); }
    public function logoFooter() { return $this->belongsTo(Media::class, 'logo_footer_id'); }
    public function favicon() { return $this->belongsTo(Media::class, 'favicon_id'); }
}