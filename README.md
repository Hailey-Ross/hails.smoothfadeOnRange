# hails.smoothfadeOnRange  
_A smooth fade-in/out script for Second Life_

This **LSL script** smoothly fades a linked object **in and out** when an avatar enters or leaves a specified range.

---

## 📜 Features
- ✅ **Smooth Fade In/Out** – No sudden pop-ins or pop-outs.  
- ✅ **Works with Linked Prims** – Entire linked objects fade together.  
- ✅ **Performance Optimized** – Avatar detection runs at set intervals to minimize lag.  

---

## ⚙️ How It Works
1. **Invisible by Default** – The object starts fully transparent.  
2. **Avatar Detection** – The script checks for nearby avatars periodically.  
3. **Smooth Transition** – When an avatar enters range, the object **gradually fades in**.  
4. **Automatic Fade-Out** – If no avatars are detected, the object **fades out smoothly**.  

---

## 🔧 Configuration Options
| Variable | Default | Description |
|----------|---------|-------------|
| `RANGE` | `10` meters | Distance at which avatars trigger the fade-in effect. |
| `FADE_STEP` | `0.05` | Speed of fading (lower = smoother, higher = faster). |
| `TIMER_INTERVAL` | `0.1` sec | Frequency of fade updates. |
| `CHECK_INTERVAL` | `2.0` sec | How often avatar detection runs (higher reduces lag). |

---

## 📜 Installation & Usage
1. **Copy & paste** the contents of `script.lsl` into a prim in Second Life.  
2. **Link multiple prims** if you want a multi-prim object to fade together.  
3. Adjust the **configuration variables** to fit your needs.  

---

## 📜 License
This script is released under the **MIT License**.  
Feel free to use, modify, and share it!  

🚀 **Enhance your Second Life objects with smooth fading effects!** 🚀  
