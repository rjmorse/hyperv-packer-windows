# Overview

## Goal of this project

Create a Minimal Viable Project for Packer and Hyper-V, for Server 2012r2, 2016 and Server 2019 images.

## QUICKSTART

1. Download eval media for 2016 and place in `.\iso`
2. Run `.\make_unattend_iso.ps1`
3. Run `.\Start-Pipeline.ps1 -Build2019` (specify via switch to build any of 3 images: `-Build2012r2`, `-Build2016`, `-Build2019`)
4. Wait for it to run and generate the image
   1. 30m for 2019 with Updates
   2. See .`\example-packer-output.txt` for sample console output
5. Remove `output-hyperv-iso` once you grabe the VHDX file (auto move/remove is pending)

## CURRENT STATUS

- 2012r2, 2016 and 2019 pipelines tested to be working using eval ISO media
  - Updates working for 2019
  - Desktop Experience
  - WinRM and RDP enabled
  - Autounattend for imaging working
  - Unattend for sysprep working
  - User: vagrant/vagrant
- Next:
  - Validate updates for 2012r2 and 2016
  - Review autounattend.xml files and remove anything that is extra
  - export/capture VHDX in addition to creating vagrant box (using post-processors, artifice, and powershell via shell-local)

## Milestones

1. Packer running on Windows to create a minimal VHDX that can start up as a Vagrant image. No customizations or configurations beyond the minimum required.
   1. Generation 2
2. Gitlab runner integration and CI pipeline enablement
3. VHDX created for 2016 and 2019, core and desktop experience
4. Windows updates integration, with upstream Microsoft and WSUS
5. Pester test integration for images
6. Capture VHDX as WIM (for consumption by MDT to image physical)
7. Ability to build on a previous stage
   1. Differencing disks
   2. Cloning disks
8. Fan-out of pipeline, with cloning of VM from previous stage

## Prerequisites

1. Windows Server 2016, 2019 media
2. Windows Server 2016 or 2019 for running, with Hyper-V enabled
3. Packer >= 1.4.3 (minimum required for Gen2 success)

## Reference projects

This would not be possible if it were not for the great work of others. That includes the maintainers of Packer and the users that submit useful Github issues; it also includes Windows Packer config work from the likes of Joe Fitzgerald, Stefan Scherer, Patrick Lang.

- <https://github.com/hashicorp/packer>
- <https://github.com/StefanScherer/packer-windows/>
- <https://labman2018.umd.edu/presentations/501-LabMan2018-Automated-Windows-Image-Creation.pdf>
- <https://mwclearning.com/?p=1935>
- <https://github.com/cryps1s/DARKSURGEON>
