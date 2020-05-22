## [1.0.1] - 2020-02-01
### Added
- bastion-image-retail folder, with configuration of bastion image to Kubernetes Cluster
- Add Output Variables for Container Registry

### Modified
- Drone.yml File including deployment of Images with Packer
- init_setup.sh Include Docker Build of Drone-Packer Images and validation if Image exist Locallly

## [1.0.0] - 2020-01-01
### Added
- Drone.yml File including deployment of Initial Infraestructure
- Git-Crypt Configuration of Secrets Files
- Infraestructure with Terraform to Deploy on Azure DNS Zone, Container Registry and Resource Groups.
- Use of Consul to Environment Configuration