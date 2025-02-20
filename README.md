# cve_manager

Project forked from [aatlasis/cve_manager](https://github.com/aatlasis/cve_manager)

The origial project was modified to and container based version.

![image](https://user-images.githubusercontent.com/1353811/171986361-04424a25-7cfc-43bf-a3d5-4f612322eaf7.png)

![image](https://user-images.githubusercontent.com/1353811/171986430-cb103943-ee85-44af-a736-26afde97d586.png)


Requires git, docker and docker-compose.

## Download project

```console
git clone https://github.com/ricardomaia/cve_manager.git
```

## Build images

```console
cd cve_manager
docker-compose build
```

## Run containers

```console
docker-compose up -d
```

## Initialization Script - First Run

```console
docker exec -it cve-manager /cve-manager/scripts/init.sh
```

## Update Script

```console
docker exec -it cve-manager /cve-manager/scripts/update.sh
```

## Manual

### Create Database

```console
./cve_manager.py -u postgres -server postgresql -db vuln_db -cd
```
  
### Create tables and views

```console
./cve_manager.py -u postgres -server postgresql -db vuln_db -ct
```

### Import Database

```console
./cve_manager.py -u postgres -server postgresql -db vuln_db -idb -p
```

## cve-manager.py

A python script that:

  a) parses NIST NVD CVEs;
  b) prcoesses and exports them to CSV files;
  c) creates a postgres database and imports all the data in it; and
  d) provides (basic) query capabilities for this CVEs database.

Usage examples:

- Download, parse and save in CSV files all CVEs from NIST NVD:
  ./cve_manager.py -d -p -csv
  
- Create a postgresql database to host the downloaded CVEs:
  ./cve_manager.py -u <myuser> host <hostname or IP> -db <database_name> -ow <new_owner of database> -cd

- Create the tables and views at the database:
  ./cve_manager.py -u <myuser> -host <hostname or IP> -db <database_name> -ct

- Import all data into the created database (requires the download, parse and sdtore as CSV files first, as explained above):
  ./cve_manager.py -u <myuser> -host <hostname or IP> -db <database_name> -idb -p

- Query for a specific CVE:
  ./cve_manager.py -u <myuser> -host <hostname or IP> -db <database_name> -cve 2019-2434

- Truncate the contents of all tables (required if you want to repeat the import process so as to update the data):
  ./cve_manager.py -u <myuser> -host <hostname or IP> -db <database_name> -tr
  
- Delete the database (remove it completely):
  ./cve_manager.py -u <myuser> -host <hostname or IP> -db <database_name> -dd

Complete list of supported arguments:

  -h, --help            show this help message and exit
  
  -v, --version         show program's version number and exit
  
  -p, --parse           Process downloaded CVEs.
  
  -d, --download        Download CVEs.
  
  -y YEAR, --year YEAR  The year for which CVEs shall be downloaded (e.g. 2019)
  
  -csv, --cvs_files     Create CSVs files.
  
  -idb, --import_to_db  Import CVEs into a database.
  
  -i INPUT, --input INPUT
                        The directory where NVD json files will been downloaded, and the one from where they will be parsed
                        (default: nvd/)

  -o RESULTS, --output RESULTS
                        The directory where the csv files will be stored (default: results/)

  -u USER, --user USER  The user to connect to the database.
  
  -ow OWNER, --owner OWNER
                        The owner of the database (if different from the connected user).

  -host HOST, --host HOST
                        The host or IP of the database server.

  -db DATABASE, --database DATABASE
                        The name of the database.

  -cd, --create_database
                        Create the database

  -dd, --drop_database  Drop the database
  
  -ct, --create_tables  Create the tables of the database
  
  -tr, --truncate_cves_tables
                        Truncate the CVEs-related tables

  -cve CVE, --cvs_number CVE
                        Print info for a CVE (CVSS score and other)

Please check the CVE Manager pdf file for more capabilities, information, and screenshots.
