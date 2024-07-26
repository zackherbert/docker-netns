# docker-netns

This is a systemd service which can be used to create a docker network
which will redirect all the traffic to a specific network namespace (netns).

It requires an existing netns which already has an available external connection using a tun link.
This can be provided with this [openvpn-netns systemd service](https://github.com/zackherbert/openvpn-netns?tab=readme-ov-file#systemd-service).

The service will execute the steps explained [here](https://github.com/moby/moby/issues/47828#issuecomment-2109596353).

## Installing

Run `sudo make install`.

## Adding a new service for a new docker network

You can add as many docker network as you want in different existing network namespaces.

Let's suppose your netns is named `vpn0`.

The systemd service will create:

 - a new docker network named `vpn0net`
 - using the ip link `vpn0bridge`.
 - a pair of veth interfaces `vpn0-int` and `vpn0-ext`, inside and outside the netns.

Start the new service:

    sudo systemctl start docker-netns@vpn0.service

Check the logs:

    journalctl -u docker-netns@vpn0.service

Enable it at boot:

    sudo systemctl enable docker-netns@vpn0.service

You can then test your new docker network with `--net=vpn0net`:

    docker run -it --rm --net=vpn0net --volume /etc/netns/vpn0/resolv.conf:/etc/resolv.conf:ro alpine sh
