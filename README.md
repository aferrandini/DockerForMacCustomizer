OSX Docker customization on start up
------------------------------------

This image and docker-compose file creates a container that will adds files to /etc
and certificates to your native Docker for Mac instance.

I have created this repository because unless Docker for Mac is stable version, you
can change files inside the Docker engine but those changes will not persist after
restarting your Docker engine. So, this is the way I found to "persist" those
changes after restarting the Docker engine.

# How it works

- First, an image with the files and certificates you want to persist in your Docker
engine will be created.
- Runing docker-compose a new container will be created form the image created before.
- Every time the container is run, the changes will be applied to the Docker engine files.
- The container will be set to restart always. So, everytime you restart your Docker
engine, the container will be run automatically and the changes will be applied to the
files.

# Usage

## Clone the repository

```bash
git clone https://github.com/aferrandini/DockerForMacCustomizer.git
```

## Adding certificates

To add some certificates to your Docker instance, just add your certificates to the
`build/certificates` folder as follows:

```bash
.
└── build
    └── certificates
        ├── hostname_1:port
        |   └── ca-certificates.crt
        └── hostname_2:port
            └── ca-certificates.crt
```

## Customizing /etc files

To customize `/etc` files you have to create the file inside `build/etc` folder and the
content will be attached to the file. If the file does not exists, the script will create
it.

```bash
.
└── build
    └── etc
        ├── my-file.txt
        └── hosts
```

In this example, the container will attach the content of your `build/etc/hosts` file to
the Docker machine `/etc/hosts` file, and will create a new file at `/etc/my-file.txt` 
with the content of your `build/etc/my-file.txt`.

# Applaing the changes to Docker Engine

Once you have create the files inside the folder structure, you have to run build the image
and run a container. This will be done with `docker-compose`. You have to run this command:

```bash
docker-compose build && docker-compose up -d
```

This command will build the image and run a container that should be running forever in
your Docker for Mac instance.

After restarting Docker service, you will see the container running and your files updated
inside your Docker engine.

# Next steps

For the next release, I want to create an image and use a volume to attach the
files and the certificates, instead of building the image with `docker-compose`.

# Colaborating

Please, feel free to colaborate and make any sugestions about this repository and how this 
problem is solved.

