<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Str;

class GenerateKeyCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generate:key';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate a new app key';

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        // Generate a new app key
        $key = Str::random(32);

        // Update the .env file with the new app key
        file_put_contents(base_path('.env'), str_replace(
            'APP_KEY=' . env('APP_KEY'),
            'APP_KEY=' . $key,
            file_get_contents(base_path('.env'))
        ));

        // Output success message
        $this->info('New app key generated successfully: ' . $key);
    }
}
