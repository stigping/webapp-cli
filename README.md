# 🛠️ WebApp CLI

A lightweight CLI toolkit for scaffolding and managing multi-container web applications using Docker. Designed to work seamlessly with the [next-template-docker](https://github.com/stigping/next-template-docker) stack.

---

## 📦 Features

- 🔧 One-command setup for new apps
- ⚙️ Generates `.env` files with unique ports
- 🐳 Launches Docker containers with `docker-compose`
- 📄 Automatically registers apps in a central `apps.json` file
- 🔁 Supports install, uninstall, rebuild, list, and status operations
- 📂 Keeps your project directory organized

---

## 🚀 Quick Start

```bash
# Install a new app
webapp install

# View all installed apps
webapp list

# View container health/status
webapp status

# Rebuild and restart an app
webapp rebuild

# Remove an app completely
webapp uninstall
```

---

## 📁 Project Structure

This CLI expects your directory to look like this:

```
/opt/webapps/
├── next-template-docker/    # Template app folder (required)
├── webapp-cli/              # This CLI repo
├── test-project/            # Example generated app
├── apps.json                # Registry of all apps
```

---

## 🔗 Related Projects

- [next-template-docker](https://github.com/stigping/next-template-docker) — base template used by this CLI

---

## 📄 License

MIT © [stigping](https://github.com/stigping)
