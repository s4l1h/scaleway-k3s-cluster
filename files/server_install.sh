#!/bin/bash -x
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable-agent --tls-san ${server_ip}" sh -