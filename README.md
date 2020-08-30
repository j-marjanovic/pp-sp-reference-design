# Bring-up project for Statix V on OTMA board

## Software generation

Here are the commands which were used to generate software project. Maybe this
can be useful when setting up single-script build for CI.

### Generate BSP

```
nios2-bsp hal . ../../qsys/system.sopcinfo --cpu-name nios2_gen2_0 --type-version 16.1
```

### Generate application

```
nios2-app-generate-makefile --app-dir . --bsp-dir ../otma_bringup_bsp --elf-name
```
