100GB云硬盘随机IO测试，使用FIO测试

4k 随机写
fio -ioengine=libaio -bs=4k -direct=1 -thread -rw=randwrite -size=10G -filename=/dev/vdb -name="EBS 4KB randwrite test" -iodepth=32 -runtime=60
4k 随机读
fio -ioengine=libaio -bs=4k -direct=1 -thread -rw=randread -size=10G -filename=/dev/vdb -name="EBS 4KB randread test" -iodepth=8 -runtime=60

100GB云硬盘顺序IO测试，使用FIO测试
4k 顺序写
fio -ioengine=libaio -bs=4k -direct=1 -thread -rw=write -size=10G -filename=/dev/vdb -name="EBS 4KB randwrite test" -iodepth=32 -runtime=60
4k 顺序读
fio -ioengine=libaio -bs=4k -direct=1 -thread -rw=read -size=10G -filename=/dev/vdb -name="EBS 4KB randread test" -iodepth=8 -runtime=60

100GB云硬盘读吞吐测试，使用FIO测试
fio -ioengine=libaio -bs=512k -direct=1 -thread -rw=read -size=100G -filename=/dev/vdb -name="EBS 512KB seqwrite test" -iodepth=64 -runtime=60

100GB云硬盘写吞吐测试，使用FIO测试
fio -ioengine=libaio -bs=512k -direct=1 -thread -rw=write -size=100G -filename=/dev/vdb -name="EBS 512KB seqwrite test" -iodepth=64 -runtime=60
