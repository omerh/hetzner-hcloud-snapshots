# Hetzner hcloud snapshots

Simple script to do snapshots on all servers in a project in Hetzner cloud.

The script is based on [hcloud-cli](https://github.com/hetznercloud/cli)

To run it using docker:

```bash
docker run --rm -e HCLOUD_TOKEN=[your hetzner token] \
  -e KEEP=3 \
  omerh/hetzner-hcloud-snapshots
```

>KEEP is optional, default is 2