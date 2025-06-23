# Vintage Story Docker Server (v1.20.12)

> Update: My naming convention has changed, builds will now be tagged with the version they support (as well as vanilla or modded) and the name of the image itself has been clarified. As a result the README.md you're reading may be slightly off. Apologies for that!

This Docker container launches a fully functional Vintage Story server with:

- ✅ Automatic whitelist disabling on startup
- ✅ Full CLI command support from the terminal
- ✅ Persistent world saves and player data
- ✅ Designed for visual control via Docker Desktop

---

## 🐳 How to Run

> **🪟 Note for Windows Users:**  
> You do **not** need to run any `.sh` script yourself.  
> Docker automatically runs the startup script *inside* the container.  
> Just make sure Docker Desktop is installed and running.  
> Run the `docker run` command from PowerShell or CMD exactly as shown.

Run this **one time** from your terminal to initialize everything:

```plaintext
docker run -it --name vintage-server \
  -p 42420:42420 \
  -v "$(pwd)/server/data:/root/.config/VintagestoryData" \
  lowerparchment/vintage_story_server:yourAppropriateTaggedVersionHere
```

If pasting the command is giving you trouble, you can also use it all in one line:

```plaintext
docker run -it --name vintage-server -p 42420:42420 -v "$(pwd)/server/data:/root/.config/VintagestoryData" lowerparchment/vintage_story_server:yourAppropriateTaggedVersionHere
```

### What this does:
- Binds port `42420` for multiplayer
- Mounts the `./server/data` folder to store all world saves and configs
- Starts the server in interactive mode so you can type into the console, though it will be updating logs live so you will need to be quick with server commands like "/op yourName" for example.

> As always don't forget to port forward your router!

---

## 👣 First-Time Setup Instructions

1. Run the container using the command above.
2. Launch Vintage Story and connect to your server.
3. Inside the terminal (server console), type or paste:

   ```plaintext
   /op YourPlayerName
   ```

   This gives you admin rights and allows you to run server commands **from inside the Vintage Story game client**, avoiding the need to use the console going forward.

---

## 🔒 Re-Enabling Whitelist (Optional)

Once you're admin in-game, you can re-enable whitelist mode by entering:

```plaintext
/serverconfig whitelistmode on
/whitelist add YourPlayerName
```

> ⚠️ **IMPORTANT WARNING**  
> If you re-enable whitelist mode **without whitelisting yourself**, you will be **locked out of your own server**.

To fix this:
- You’ll need to return to the **server terminal** and run:

  ```plaintext
  /whitelist add YourPlayerName
  ```

- This requires fighting through the rapidly scrolling server log output in the terminal to enter the command — **so it's highly recommended you add yourself to the whitelist first, before turning it on.**

---

## 🖥 Managing the Server

Once the server is created, you can start/stop/restart it from **Docker Desktop** using the visual UI:

- Click **Start**, **Stop**, or **Restart**
- Click **CLI** to enter the terminal
- View live logs or container details with one click

You can also use this command in the terminal to restart manually if you prefer it over docker desktop:

```bash
docker start -ai vintage-server
```

---

## 🧼 Resetting the Server

To completely reset the server, simply delete the mounted volume through docker desktop, and make sure your dir is clean of the saved folders (world, configs, player data):

```bash
docker rm -f vintage-server
rm -rf ./server/data
```

Then re-run the original `docker run` command to start clean.

---

## 🔁 Summary

| Task | Command |
|------|---------|
| One-time setup | `docker run -it --name vintage-server -p 42420:42420 -v "$(pwd)/server/data:/root/.config/VintagestoryData" lowerparchment/vintage_story_server:yourAppropriateTaggedVersionHere` |
| Rejoin server | `docker start -ai vintage-server` or use Docker Desktop |
| Grant admin from active server console | `/op YourPlayerName` |
| Enable whitelist (optional) | `/serverconfig whitelistmode on` + `/whitelist add YourPlayerName` |
| Reset server | `docker rm -f vintage-server` + `rm -rf ./server/data` |

---

You’re now fully set up with a persistent, admin-friendly, GUI-manageable Vintage Story server. Enjoy!

**Last updated:** June 20, 2025