import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "src")
DIST = os.path.join(ROOT, "dist")
OUTPUT = os.path.join(DIST, "main.lua")

ORDER = [
    "01_Bootstrap.lua",
    "02_Icons.lua",
    "03_IconKeybindResolvers.lua",
    "04_AcrylicEffects.lua",
    "05_ThemeUtils.lua",
    "06_CoreUtilities.lua",
    "07_Window.lua",
    "08_WindowMethods.lua",
    "09_Tabs.lua",
    "Elements/Button.lua",
    "Elements/Toggle.lua",
    "Elements/Slider.lua",
    "Elements/Dropdown.lua",
    "Elements/Keybind.lua",
    "Elements/Input.lua",
    "10_InternalHelpers.lua",
    "11_Notify.lua",
    "12_Dialog.lua",
    "13_Destroy.lua",
]

def bundle():
    os.makedirs(DIST, exist_ok=True)
    chunks = []
    for relative_path in ORDER:
        full_path = os.path.join(SRC, relative_path)
        with open(full_path, "r", encoding="utf-8") as file:
            content = file.read()
        chunks.append(content.rstrip("\n"))
    final_source = "\n\n".join(chunks) + "\n"
    with open(OUTPUT, "w", encoding="utf-8") as file:
        file.write(final_source)
    print(f"Bundled {len(ORDER)} files into {OUTPUT}")

if __name__ == "__main__":
    bundle()
