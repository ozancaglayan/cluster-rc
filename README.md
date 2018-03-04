Bash aliases for SLURM
----

## Installation

Just source the file from your `.bashrc`:

```
echo source `realpath bashrc` >> ~/.bashrc
```

## Features

 - Assumes two SLURM partitions available: `cpu` and `gpu`.
 - Extends `PS1` for `srun` sessions to show remaining `TimeLimit`.

### Aliases for getting information

- All aliases can be extended by command-line arguments which will override
  the arguments given within the alias definitions.
- `sac*, sreu` are by default limiting time interval to the last day unless overriden.

| Alias          | Description |
|----------------|-------------|
| `si`                  | `sinfo` alternative with node-centric view |
| `sic`                 | `si` for CPU partition |
| `sig`                 | `si` for GPU partition |
| `sq`                  | `squeue` alternative |
| `sqc`                 | `sq` for CPU partition |
| `sqg`                 | `sq` for GPU partition |
| `squ`                 | `sq` limited to user's jobs |
| `scj <jobid>`         | Calls `scontrol show job -dd` |
| `scwb <jobid>`        | Dumps `sbatch` script for the requested job |
| `sst <jobid>`         | View running job stats with `sstat` |
| `sst <jobid.batch>`   |                                     |
| `sac`                 | View user's jobs |
| `sac -S YYYY-MM-DD`   | View user's jobs between YYYY-MM-DD and now |
| `sacr`                | View user's running jobs |
| `sacf`                | View user's jobs where state is one of `FAILED,DEADLINE,TIMEOUT,NODE_FAIL,CANCELLED`|
| `sreu`                | View top utilization report |

### Aliases for `srun`

- These are quick aliases for obtaining interactive shell through `srun`.
- All of them can be extended when ommand-line arguments `<args>` are provided.

| Alias                  | Description |
|------------------------|-------------|
| `slc`                  | Run a shell with 4GB memory for 5 hours on a CPU machine |
| `slc --time 50`        | Reduce timelimit to 50 minutes |
| `slc -w cpu02`         | Select machine `cpu02` |
| `slc -p gpu -w gpu05`  | Select `gpu` partition and machine `gpu05` |
| `slg`                  | Same as `slc` but defaults to `gpu` partition and requests 1 GPU |
| `slg -w gpu05`         | Select machine `gpu05` |
