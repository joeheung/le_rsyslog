# le_rsyslog-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

* debian
* ubuntu >= 12.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['le_rsyslog']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### le_rsyslog::default

Include `le_rsyslog` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[le_rsyslog::default]"
  ]
}
```

## License and Authors

Author:: Joe Heung (<joe@joeheung.com>)
