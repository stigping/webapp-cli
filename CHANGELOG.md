# 📦 Changelog – WebApp CLI

## [v1.0.0] – First Stable Release – May 2025

🎉 Initial stable release of the WebApp CLI for managing multi-container web apps using Docker.

### Added
- `webapp install` command for rapid app scaffolding
- Interactive domain + port input (frontend & backend)
- `.env` generation with dynamic port injection
- `apps.json` tracking for installed projects
- Support for multiple domains like `sdev.no`, `hfh.sdev.no`, etc.
- Docker health check logic
- `webapp uninstall`, `status`, `rebuild`, and `list` commands
- `.docker-compose.override.yml` support for clean port exposure

### Improved
- Works with NGINX Proxy Manager using webserver IP + exposed port
- Simplified deployment to local and remote servers
- Fully revised README with clear multi-site setup instructions

### Notes
- Use alongside the [next-template-docker](https://github.com/stigping/next-template-docker) stack.
- Future releases may include `apps.json` management CLI and backup features.
