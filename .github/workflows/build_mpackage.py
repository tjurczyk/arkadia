#!/usr/bin/env python3
"""Builds arkadia.mpackage (a plain zip) from the repository contents.

Mudlet unpacks an .mpackage into <profile>/<mpackage from config.lua>/, i.e.
into <profile>/arkadia/ -- exactly where init.lua looks for the .lua files.
It then imports EVERY *.xml and *.trigger file sitting in the ROOT of the
archive, which is why Arkadia.xml must be the only one there.
"""

import re
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

# Directories skipped entirely (matched by name, at any depth).
EXCLUDED_DIRS = {".git", ".github", ".vscode", ".idea", ".claude", "__pycache__"}

# Skipped files. ArkadiaScriptsInstaller.xml MUST be skipped -- as a second XML
# in the root it would get imported alongside Arkadia.xml.
EXCLUDED_ROOT_FILES = {
    "ArkadiaScriptsInstaller.xml",
    "installer.lua",
    "short_installer.lua",
    ".gitattributes",
    ".gitignore",
    "CODEOWNERS",
}
EXCLUDED_SUFFIXES = {".iml", ".pyc", ".mpackage"}
EXCLUDED_NAMES = {".DS_Store"}


def read_version() -> str:
    text = (ROOT / "skrypty.lua").read_text(encoding="utf-8")
    match = re.search(r'ver\s*=\s*"([\d.]+)"', text)
    if not match:
        sys.exit("no version found in skrypty.lua")
    return match.group(1)


def stamp_config(version: str) -> str:
    """Replaces version in config.lua with the version from skrypty.lua."""
    text = (ROOT / "config.lua").read_text(encoding="utf-8")
    new_text, count = re.subn(
        r'^version\s*=\s*"[^"]*"',
        f'version = "{version}"',
        text,
        count=1,
        flags=re.MULTILINE,
    )
    if not count:
        sys.exit("no version field found in config.lua")
    return new_text


def collect() -> list[Path]:
    files = []
    for path in sorted(ROOT.rglob("*")):
        if not path.is_file():
            continue
        rel = path.relative_to(ROOT)
        if EXCLUDED_DIRS.intersection(rel.parts[:-1]):
            continue
        if path.name in EXCLUDED_NAMES or path.suffix in EXCLUDED_SUFFIXES:
            continue
        if len(rel.parts) == 1 and rel.name in EXCLUDED_ROOT_FILES:
            continue
        if rel.name == "config.lua" and len(rel.parts) == 1:
            continue  # added separately, with the version injected
        files.append(rel)
    return files


def main() -> None:
    out = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / "arkadia.mpackage"
    version = read_version()
    files = collect()

    roots = [f for f in files if len(f.parts) == 1 and f.suffix in (".xml", ".trigger")]
    if roots != [Path("Arkadia.xml")]:
        sys.exit(f"archive root must contain exactly Arkadia.xml, found: {roots}")

    out.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED, compresslevel=9) as zf:
        zf.writestr("config.lua", stamp_config(version))
        for rel in files:
            zf.write(ROOT / rel, rel.as_posix())

    size = out.stat().st_size
    print(f"{out} ({version}) -- {len(files) + 1} files, {size / 1024 / 1024:.1f} MB")


if __name__ == "__main__":
    main()
