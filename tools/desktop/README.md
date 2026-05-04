# Desktop

Optional local workstation applications that are not part of the default bootstrap.

Put app installers here when they only make sense on a graphical Linux desktop, for example VS Code or Hyper. These scripts run only when bootstrap is called with:

```bash
./install.sh --desktop
```

Prefer each script to:

- exit if the application is already installed
- avoid persistent apt repositories unless you intentionally want vendor-managed updates
- clean up downloaded `.deb` files
- skip gracefully when running inside a container or non-desktop environment
