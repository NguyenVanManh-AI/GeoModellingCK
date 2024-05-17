<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Map extends Model
{
    use HasFactory;
    protected $fillable = [
        'id',
        'address',
        'coordinates',
        'imagefull',
        'px',
        'nx',
        'py',
        'ny',
        'pz',
        'nz',
        'create_id',
        'update_id',
    ];
}
