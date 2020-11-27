# Path to printer driver inf file. Has to be on local machine
pnputil.exe -i -a C:\inf.path.inf

# Name described in driver inf file. Needs to match exactly
Add-PrinterDriver -Name "Printer Driver Name"

# Swap out IP for the IP of the networked printer
Add-PrinterPort -Name "IP_192.168.1.150" -PrinterHostAddress "192.168.1.150"

# And finally add everything together and make a printer
Add-Printer -Name printer_test_name -DriverName "Printer Driver Name" -PortName IP_192.168.1.150