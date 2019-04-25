## Archimista
Archimista è un'applicazione web open source per la descrizione di archivi storici. È disponibile in due versioni: standalone e server.
Versione corrente: **3.0.0**

## Requisiti
Archimista funziona sui sistemi operativi GNU/Linux, Mac OS X, Windows Vista e superiori. Per Windows XP è necessario utilizzare una versione apposita

* Ruby 2.1.5
* Rails 4.2.1
* Varie gemme Ruby dichiarate nel file Gemfile
* Gemma rubyzip
* ImageMagick (opzionale, per la gestione di oggetti digitali)
* Database: MySQL (>= 5.1) o PostgreSQL (>= 9.1) o SQLite
* Webserver configurato per applicazioni Rails

## Installazione in container Docker

Verificare i requisiti per docker e docker-compose


1. creare il file di configurazione del database, per esempio:
```yaml
defaultMySql: &defaultMySql
  adapter:    mysql2
  encoding:   utf8
  host:       dbMy
  username:   root
  password:   generic_password
  pool:       5

development:
  <<:         *defaultMySql
  database:   archimista_development

test:
  <<:         *defaultMySql
  database:   archimista_test

production:
  <<:         *defaultMySql
  database:   archimista_production
```
2. creare il file di configuazione dei secrets, per esempio:
```yaml
development:
  secret_key_base: eb49b41d0d03e8b0aa951eb60e213e7d1ab905ec8c276c9b99be1a6cd90665d03e198fe9479f32ce839ed703efe81629388f9488b79d8842d1974bd412b4f2d7

test:
  secret_key_base: 66faed6eedb3e17674c6be1370b3b20913fe9f177f03703e807347026ad3b711b6a05cf9ea42651c3b6d6c82b2064973f2120f4113d54d44b737768e2328e60d

production:
  secret_key_base: 7ec7f033f7d1811f5d4e23351f80eeec6d3142d1cdd2eaceafc71a5951a3446b1507e738de88afb19664491ad6be0e792f9c58714c85abfdb35f031a4ad9dbaf
```
3. eseguire la build tramite Docker Compose:
```bash
docker-compose build
```
4. avviare Docker Compose con il comando start:
```bash
docker-compose up
```

5. eseguire il comando di creazione del database:
```bash
docker-compose exec web rake db:setup RAILS_ENV=production
```

6. spegnere l'applicativo tramite la pressione di ctrl + c.

#### Start applicazione
Per eseguire l'avvio dell'applicazine tramite Docker Compose digitare il comando start:
```bash
docker-compose start
```

#### Stop applicazione
Per fermare archivista eseguire:
```bash
docker-compose stop
```

## Login nell'applicazione
L'appliazione risponde all'indirizzo http://localhost:8000

L'utente per il primo login è:

* user: admin_archimista
* pass: admin_archimista

Nel caso di aggiornamento da versioni precedenti dell'applicazione:

1. Eseguire il task RAILS_ENV=production rake db:migrate
2. Eseguire il task RAILS_ENV=production rake assets:clean

## Crediti
Archimista è un progetto promosso da:

* Direzione Generale per gli Archivi
* Regione Lombardia, Direzione Generale Istruzione, Formazione e Cultura
* Università degli Studi di Pavia
* Politecnico di Milano

## Autori
Codex Società Cooperativa, Pavia
* [http://www.codexcoop.it](http://www.codexcoop.it)
TAI S.a.s.
* [http://www.taisas.com](http://www.taisas.com)

Lo sviluppo attuale è curato da INGLOBA360 s.r.l.
* [http://www.ingloba360.it](http://www.ingloba360.it)

## Licenza
Archimista è rilasciato sotto licenza GNU General Public License v2.0 o successive.

## Ringraziamenti
Grazie a @Cavva79 per il primo docker-compose dal quale ho clonato questo progetto.
