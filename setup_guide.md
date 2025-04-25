Absolutely, Steve — here’s a **simple setup guide** to wire up your media automation stack. This assumes you're running everything locally using the Docker stack you've got running.

---

## 🔁 General Flow Recap

```
[Prowlarr] → manages indexers → [Sonarr / Radarr / Readarr]
                                 ↓
                          Sends NZBs to
                                 ↓
                             [NZBGet]
                                 ↓
                       Downloads to /data/downloads
                                 ↓
               [Sonarr / Radarr / Readarr] import to media folders
                                 ↓
                           [Jellyfin] serves it all
```

---

## ✅ Step-by-Step Configuration

### 1. **NZBGet Setup**
Visit: [http://localhost:6789](http://localhost:6789)  
Default login: `nzbget / nzbget`

- Go to **Settings → Paths**
  - `MainDir`: `/data/downloads`
  - Optional: Add categories like `tv`, `movies`, `books` (Sonarr/Radarr use these)

- Go to **Settings → Security**
  - Change login credentials if desired

- Save and **restart NZBGet**

---

### 2. **Prowlarr Setup**
Visit: [http://localhost:9696](http://localhost:9696)

- Go to **Settings → Indexers → Add Indexer**
  - Choose your indexer (e.g., NZBGeek)
  - Enter API key, test, and save

- Go to **Settings → Apps → Add App**
  - Choose: Sonarr
  - URL: `http://sonarr:8989`
  - API Key: Get this from Sonarr (Settings → General)
  - Test & Save
  - Repeat for Radarr and Readarr

This makes sure indexers are shared across apps.

---

### 3. **Sonarr / Radarr / Readarr Setup**
Visit:
- Sonarr: [http://localhost:8989](http://localhost:8989)
- Radarr: [http://localhost:7878](http://localhost:7878)
- Readarr: [http://localhost:8787](http://localhost:8787)

#### Settings → Download Clients → Add Client
- Type: **NZBGet**
- Host: `nzbget`
- Port: `6789`
- Username / Password: (your NZBGet credentials)
- Category: e.g., `tv` for Sonarr, `movies` for Radarr, `books` for Readarr
- Test → Save

#### Settings → Media Management → Root Folders
- Add root folder:
  - Sonarr → `/data/media/tv`
  - Radarr → `/data/media/movies`
  - Readarr → `/data/media/books`

#### Optionally:
- Enable **"Remove Completed Downloads"** so it doesn't leave junk in `/downloads`

---

### 4. **Bazarr Setup (for subtitles)**
Visit: [http://localhost:6767](http://localhost:6767)

- Link to Sonarr and Radarr under Settings → Services
- Configure subtitle providers
- Set default languages and download behavior

---

### 5. **Jellyfin Setup**
Visit: [http://localhost:8096](http://localhost:8096)

- Go through initial setup
- Add libraries:
  - Type: TV Shows → `/data/media/tv`
  - Type: Movies → `/data/media/movies`
  - Type: Books (audiobooks or other formats if supported) → `/data/media/books`

---

## 🧪 Final Test
1. Add a show in Sonarr.
2. It finds it via Prowlarr → sends to NZBGet.
3. NZBGet downloads to `/data/downloads`.
4. Sonarr imports to `/data/media/tv`.
5. Jellyfin sees the new file and adds it to your library.

---

Let me know if you want a **printable checklist version**, or want to automate this with a pre-configured settings export.
