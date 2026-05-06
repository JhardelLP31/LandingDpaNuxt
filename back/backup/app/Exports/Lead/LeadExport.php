<?php

namespace App\Exports\Lead;

use App\Models\Lead\Lead;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\Exportable;
use Carbon\Carbon;

class LeadExport implements FromQuery, WithHeadings, WithMapping
{
    use Exportable;

    protected $startDate;
    protected $endDate;

    public function __construct($startDate = null, $endDate = null)
    {
        $this->startDate = $startDate;
        $this->endDate = $endDate;
    }

    public function query()
    {
        $query = Lead::query();

        if (!empty($this->startDate) && !empty($this->endDate)) {
            $start = Carbon::parse($this->startDate)->startOfDay();
            $end   = Carbon::parse($this->endDate)->endOfDay();
            $query->whereBetween('created_at', [$start, $end]);
        }

        return $query->orderBy('created_at', 'desc');
    }

    public function headings(): array
    {
        return [
            'ID', 
            'Nombre Completo', 
            'Email', 
            'Teléfono', 
            'Tipo Formación',
            'Curso Interés',
            'Estado', 
            'Origen (URL)', 
            'Mensaje', 
            'Fecha Registro'
        ];
    }

    public function map($lead): array
    {
        $statusMap = [
            'new' => 'Nuevo', 'contacted' => 'Contactado', 'spam' => 'Descartado'
        ];

        // Accedemos al array metadata con seguridad
        // Usamos '??' por si el lead es antiguo y no tiene esos datos.
        $formationType  = $lead->metadata['formation_type'] ?? '-';
        $courseInterest = $lead->metadata['course_interest'] ?? '-';

        return [
            $lead->id,
            $lead->first_name . ' ' . $lead->last_name,
            $lead->email,
            $lead->phone,
            
            $formationType,
            $courseInterest,
            
            $statusMap[$lead->status] ?? 'Otro',
            $lead->origin_url,
            $lead->message,
            $lead->created_at->format('d/m/Y H:i'),
        ];
    }
}