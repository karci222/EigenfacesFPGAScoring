import serial
import random
import unittest
import time
from serial.tools import list_ports
import sys

class SerialCom():
    def setUpCom(self):
        self.ser = serial.Serial(
            port = 'COM4',
            baudrate = 115200,
            parity = serial.PARITY_NONE,
            stopbits = serial.STOPBITS_ONE,
            bytesize = serial.EIGHTBITS,
            timeout = 0.5,
            xonxoff = 0,
            rtscts = 0
        )
        print(self.ser.isOpen())
        if self.ser.inWaiting() > 0:
            self.ser.read(self.ser.inWaiting())
    def closeCom(self):
        self.ser.close()
    def send_ghost(self, ghost_image):
        self.setUpCom()
        self.ser.reset_input_buffer()
        self.ser.reset_output_buffer()
        command = 0x67
        print(self.ser.write(command.to_bytes(1, byteorder="big", signed=False)))
        self.ser.flush()
        time.sleep(0.2)
        while self.ser.in_waiting < 0:
            print("Sending command... ", self.ser.in_waiting)
        self.burst_data(ghost_image)
        print("Data sent...")
        self.closeCom()
    def send_sample(self, sample_image):
        self.setUpCom()
        self.ser.reset_input_buffer()
        self.ser.reset_output_buffer()
        command = 0x73
        self.ser.write(command.to_bytes(1, byteorder="big", signed=False))
        time.sleep(0.2)
        while self.ser.in_waiting > 0:
            print("Sending command...", self.ser.in_waiting)
        self.burst_data(sample_image)
        print("Data sent...")
        self.closeCom()
    def perform_test(self):
        self.setUpCom()
        command = 0x63
        self.ser.write(command.to_bytes(1, byteorder="big", signed=False))
        data = self.ser.read(size = 4)
        print("Bytes returned: ", len(data))
        print("Bytes: ", data)
        self.closeCom()
    def read_result(self):
        self.setUpCom()
        command = 0x65
        self.ser.write(command.to_bytes(1, byteorder="big", signed=False))
        data = self.ser.read(size = 4)
        print("Bytes returned: ", len(data))
        print("Bytes: ", hex(data[3]), hex(data[2]), hex(data[1]), hex(data[0]))
        self.closeCom()
    def test_connection(self):
        self.setUpCom()
        self.ser.reset_input_buffer()
        self.ser.reset_output_buffer()
        command = 116
        print(self.ser.write(command.to_bytes(1, byteorder="big", signed=False)))
        s = self.ser.read(1)
        self.ser.reset_input_buffer()
        self.ser.reset_output_buffer()
        self.closeCom()
        if s == b't':
            print("SUCCESS!!!")
        else:
            print("FAILURE!!!!")
    def start_recognition(self):
        self.setUpCom()
        self.ser.reset_input_buffer()
        self.ser.reset_output_buffer()
        command = 0x61
        self.ser.write(command.to_bytes(1, byteorder="big", signed=False))
        data=self.ser.read(size=4)
        print("Bytes returned: ", len(data))
        print("Bytes: ", hex(data[3]), hex(data[2]), hex(data[1]), hex(data[0]))
        self.closeCom()
        return data
    def burst_data(self, data):
        """
        Slices data into smaller blocks and bursts them
        """
        print(len(data))
        i = 0
        while i < len(data):
            #print(i)
            dat = int(data[i])
            self.ser.write(dat.to_bytes(1, byteorder="big", signed=False))
            i = i + 1
            #time.sleep(0.001)
    
    def conv_int(self, data):
        data_new = [0 for x in range(len(data))]
        for i in range(len(data)):
            data_new[i] = int(data[i])
            
        return data_new