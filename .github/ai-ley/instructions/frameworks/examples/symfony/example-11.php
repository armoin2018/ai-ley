// src/Command/ImportUsersCommand.php
<?php

namespace App\Command;

use App\Service\UserImportService;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:import:users',
    description: 'Import users from CSV file'
)]
class ImportUsersCommand extends Command
{
    public function __construct(
        private UserImportService $importService
    ) {
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addArgument('file', InputArgument::REQUIRED, 'Path to CSV file')
            ->addOption('dry-run', null, InputOption::VALUE_NONE, 'Run without persisting data')
            ->addOption('batch-size', 'b', InputOption::VALUE_OPTIONAL, 'Batch size for processing', 100);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $file = $input->getArgument('file');
        $dryRun = $input->getOption('dry-run');
        $batchSize = (int) $input->getOption('batch-size');

        if (!file_exists($file)) {
            $io->error("File not found: {$file}");
            return Command::FAILURE;
        }

        $io->title('User Import');
        
        if ($dryRun) {
            $io->note('Running in dry-run mode');
        }

        $result = $this->importService->importFromCsv($file, $batchSize, $dryRun);

        $io->success([
            "Import completed successfully!",
            "Processed: {$result['processed']} users",
            "Created: {$result['created']} users",
            "Errors: {$result['errors']} users"
        ]);

        return Command::SUCCESS;
    }
}