---
sidebar_position: 1
---
# Installation

Let's discover **Static Hands in less than 5 minutes**.

## Getting Started

First of all, **install** [**AutoHotKey**](https://www.autohotkey.com/). Then:

* **Option one**: Simply install the file by running the install.bat as an administrator (makes Static Hands load on the computer's startup).
* **Option two**: Install the file by clicking the install.exe (won't move Static Hands to startup folder).
* **Option three**: Clone project, run static-hands --> Windows --> run.ahk with AutoHotkey. To put ahk into effect automatically every time PC start

  * Select run.ahk, and press Ctrl+C.
  * Press Win+R to open the Run dialog, then enter shell:startup and click OK or Enter. This will open the Startup folder for the current user. To instead open the folder for all users, enter shell: common startup (however, in that case, you must be an administrator to proceed).
  * Right-click inside the window, and click "Paste Shortcut". The shortcut to the script should now be in the Startup folder.


Get started by **creating a new site**.

Or **try Docusaurus immediately** with **[new.docusaurus.io](https://new.docusaurus.io)**.

## Generate a new site

Generate a new Docusaurus site using the **classic template**:

```shell
npx @docusaurus/init@latest init my-website classic
```

## Start your site

Run the development server:

```shell
cd my-website

npx docusaurus start
```

Your site starts at `http://localhost:3000`.

Open `docs/intro.md` and edit some lines: the site **reloads automatically** and display your changes.
