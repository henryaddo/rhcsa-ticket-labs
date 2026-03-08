# Ticket 006 — Configure Static Networking with nmcli

## Business Context
A server must be moved from DHCP to a static network configuration for stable application connectivity.

## Requirements
1) Identify the active NetworkManager connection.
2) Configure the active connection with:
   - IPv4 address: `192.168.122.50/24`
   - Gateway: `192.168.122.1`
   - DNS server: `8.8.8.8`
3) Set IPv4 method to manual.
4) Bring the connection up.
5) Verify IP address, default route, and DNS settings.

## Constraints
- Use `nmcli`.
- Do not edit ifcfg files manually.
- Verify the active profile before making changes.

## Acceptance Criteria
- `nmcli con show` shows the modified connection
- `ip -br a` shows the configured static IP
- `ip r` shows the correct default route
- `nmcli dev show` shows the configured DNS server
- The connection comes up successfully after applying changes
