<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class TestArtisanInUnitest extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'test:unitest';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command test run artisan in testing unitest';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        return Command::SUCCESS;
    }
}
