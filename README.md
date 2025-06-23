# Vintage Story Docker Server Collection

This repository contains all currently supported versions of **Minecraft** server images that I've created.  
Each version is organized under its appropriate category: `vanilla/`, `modded/`, or other custom flavors.

---

## 🗂️ Folder Structure

```
vintage_story_server/
├── vanilla/
│   ├── [version]/
│   └── ...
├── modded/
│   ├── [version]/
│   └── ...
```

Each `[version]` folder contains:
- A `Dockerfile` for that specific version
- A `start.sh` script or launcher
- A `server/` directory (excluded from Git) to hold your world data and downloaded binaries
- Its own `README.md` with run instructions

---

## 🚀 Getting Started

1. Browse to the version you want under either `vanilla/`, `modded/`, or otherwise.
2. Open that folder’s `README.md`
3. Follow the instructions to:
   - Pull or build the image
   - Mount local volumes
   - Run the server container

---

## 🧼 Note on Repo Size

Game binaries and world save data are excluded from Git to keep the repository lightweight.  
All server files are downloaded automatically during container startup.

---

## 📬 Questions?

Feel free to open an issue or reach out if you need help with a particular setup.
