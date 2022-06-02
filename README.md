# RabbitMQ on Render

This is a template repo for running a RabbitMQ instance as a **web service** on
Render.

It uses the [official Dockerfile](https://hub.docker.com/_/rabbitmq) and backs
RabbitMQ with a [Render disk](https://render.com/docs/disks), making it 
resilient to data loss in the case of restarts or deploys.

### Deployment

See https://render.com/docs/deploy-rabbitmq.

### Permissions fixes

When upgrading from 3.7.17 to 3.9.18, the Docker image's original entrypoint
script consistently fails due to permissions issues - in particular, the
`/var/lib/rabbitmq/.erlang.cookie` file cannot be opened because it is owned
by group 1000 instead of group `rabbitmq (gid: 999)`.

In order to resolve this issue, we modify `docker-entrypoint.sh` so that the
erlang cookie file is explicitly owned by `rabbitmq:rabbitmq`. The modified
script is created by copying the entrypoint script out of the docker container
and manually modifying it. The Dockerfile for the image we deploy on Render 
then instructs Docker replace the entrypoint script with our modified one.

If RabbitMQ versions are updated in the future, make sure to remember to look
at the entrypoint script - we may need to upgrade it (though hopefully we won't
need a modified entrypoint script at all!).
