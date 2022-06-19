# Cultural Berlin

`Cultural Berlin` is a service that collects all the cultural activities in Berlin into one site.  
There are two resources that can provide you with this information.

# Web Resources
- CO Berlin(https://co-berlin.org/en/program/calendar)
- Berghain(https://www.berghain.berlin/en/program/)

# DB table
|  Key  |  Type  |  Description  |
| ---- | ---- | ---- |
|  id  |  bigint  | ID(primary key) |
|  date  |  Date  | event date |
|  name  |  string  | event name |
|  source  |  string  | web source |
|  url  |  string  | event url |

# Features:

## Search events
- Search Keys
  - Event name
  - Event date
  - Web source

## Update event info automatically
- daily update

# Tech:
- Ruby on Rails
  - Ruby: 3.1.1
  - Rails: 6.1.6
- PostgreSQL
- Docker

# Development
- ./bin/update.sh
