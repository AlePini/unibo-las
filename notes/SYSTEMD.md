[Service]
Type=simple
ExecStart= "path to binary"
Restart=on-failure

[Install]
WantedBy= basic.target
