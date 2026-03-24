# Citronics APT Repository

APT package repository for Citronics Lime (Fairphone 2) boards running Debian or Ubuntu.

## Adding the repository

**Recommended** (GitHub Pages):

```
echo "deb [trusted=yes] https://citronics.github.io/deb-packages/ stable main" | sudo tee /etc/apt/sources.list.d/citronics.list
sudo apt update
```

**Legacy** (raw.githubusercontent.com — deprecated, will be retired):

```
echo "deb [trusted=yes] https://raw.githubusercontent.com/Citronics/deb-packages/main stable main" | sudo tee /etc/apt/sources.list.d/citronics.list
sudo apt update
```

## Available packages

| Package | Description | Source repo |
| --- | --- | --- |
| `citronics-lime` | Transitional meta-package (depends on `citronics-lime-fp2`) | this repo |
| `citronics-lime-fp2` | Board-specific meta-package (carrier-lime, board-fp2) | this repo |
| `linux-image-*-citronics-lime` | Kernel image | [lime-image](https://github.com/Citronics/lime-image) |
| `linux-headers-*-citronics-lime` | Kernel headers | [lime-image](https://github.com/Citronics/lime-image) |
| `linux-firmware-lime` | Proprietary firmware | [linux-firmware-lime](https://github.com/Citronics/linux-firmware-lime) |
| `citronics-initramfs` | Custom initramfs | [initramfs](https://github.com/Citronics/initramfs) |
| `unudhcpd` | USB DHCP helper | [unudhcpd-deb](https://github.com/Citronics/unudhcpd-deb) |

Meta-packages follow the naming pattern `citronics-{carrier}-{board}` (e.g., `citronics-lime-fp2`). To add a new carrier or board combination, create a new meta-package under `meta-packages/citronics-{carrier}-{board}/` in this repository. The `build-meta.sh` script automatically discovers all meta-packages via a dynamic loop — no script changes needed when adding carriers.

To install everything:

```
sudo apt install citronics-lime
```

## How the repository works

Each source repo has a `release.sh` script that builds `.deb` packages and publishes them as GitHub Releases using the `gh` CLI. Versions are derived from git tags.

This repository has a GitHub Actions workflow (`update-repo.yml`) that downloads all `.deb` assets from the 4 source repos, generates APT metadata with `apt-ftparchive`, and publishes the result to GitHub Pages via the `gh-pages` branch.

### Updating the repository after a new release

1. In the source repo, tag and release:
   ```
   git tag v<version>
   git push origin v<version>
   ./release.sh
   ```

2. Then trigger the APT repo update:
   ```
   gh workflow run update-repo.yml --repo Citronics/deb-packages
   ```

   Or trigger it manually from the [Actions tab](https://github.com/Citronics/deb-packages/actions/workflows/update-repo.yml).

## License

By using any of the packages in this repo, you accept the licenses of all the individual packages. Check each source repository for details.
