# mi-qutic-piwik

use [jfqd/mi-qutic.base](https://github.com/jfqd/mi-qutic-base) to create a provisionable image

## description

image with piwik, apache-24 and php71.

## build the image

```
cd /opt/mibe/
git clone https://github.com/jfqd/mi-qutic-piwik.git
BASE64_IMAGE_UUID=$(imgadm list | grep qutic-base-64 | tail -1 | awk '{ print $1 }')
TEMPLATE_ZONE_UUID=$(vmadm lookup alias='qutic-base-template-zone')
../bin/build_smartos $BASE64_IMAGE_UUID $TEMPLATE_ZONE_UUID mi-qutic-piwik
```

## upload image to dsapid

```
curl -v -u your-secure-admin-token: https://dsapid.example.com/api/upload /
  -F manifest=@/opt/mibe/images/qutic-piwik-17.4.0-dsapi.dsmanifest /
  -F file=@/opt/mibe/images/qutic-piwik-17.4.0.zfs.gz
```

## mdata variables

See [mi-qutic-base Readme](https://github.com/jfqd/mi-qutic-base/blob/master/README.md) for a list of usable metadata.

## installation

The following sample can be used to create a zone running a copy of the the nextcloud image.

```
IMAGE_UUID=$(imgadm list | grep 'qutic-piwik' | tail -1 | awk '{ print $1 }')
vmadm create << EOF
{
  "brand":      "joyent",
  "image_uuid": "$IMAGE_UUID",
  "alias":      "piwik",
  "hostname":   "piwik.example.com",
  "dns_domain": "example.com",
  "resolvers": [
    "80.80.80.80",
    "80.80.81.81"
  ],
  "nics": [
    {
      "interface": "net0",
      "nic_tag":   "admin",
      "ip":        "10.10.10.10",
      "gateway":   "10.10.10.1",
      "netmask":   "255.255.255.0"
    }
  ],
  "max_physical_memory": 1024,
  "max_swap":            1024,
  "quota":                 10,
  "cpu_cap":              100,
  "customer_metadata": {
    "admin_authorized_keys": "your-long-key",
    "root_authorized_keys":  "your-long-key",
    "mail_smarthost":        "mail.example.com",
    "mail_auth_user":        "you@example.com",
    "mail_auth_pass":        "smtp-account-password",
    "mail_adminaddr":        "report@example.com",
    "munin_master_allow":    "munin-master.example.com",
    "vfstab":                "storage.example.com:/export/data    -       /data    nfs     -       yes     rw,bg,intr",
    "server_name":           "piwik.example.com",
    "server_alias":          "piwik.example.net,
    "data_path":             "/data/shared/data",
    "config_copy_path":      "/data/shared/config" 
  }
}
EOF
```

## todo

* Truncate Apache log
* Add ssl-support
* config.ini-php support
