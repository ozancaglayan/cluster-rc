Bash aliases for SLURM
----

## Installation

Just source the file from your `.bashrc`:

```
echo source `realpath bashrc` >> ~/.bashrc
```

## Features

Assumes two SLURM partitions available: cpu and gpu.

 - Sets `$PS1` for `srun` sessions to show remaining `TimeLimit`.
 - `sinfo` aliases:
  - `si`: `sinfo` replacement
  - `sic`: `si` for CPU partition
  - `sig`: `si` for GPU partition
