系统性能状态{

    vmstat 1 9

    r      # 等待执行的任务数。当这个值超过了cpu线程数，就会出现cpu瓶颈。
    b      # 等待IO的进程数量,表示阻塞的进程。
    swpd   # 虚拟内存已使用的大小，如大于0，表示机器物理内存不足，如不是程序内存泄露，那么该升级内存。
    free   # 空闲的物理内存的大小
    buff   # 已用的buff大小，对块设备的读写进行缓冲
    cache  # cache直接用来记忆我们打开的文件,给文件做缓冲，(把空闲的物理内存的一部分拿来做文件和目录的缓存，是为了提高 程序执行的性能，当程序使用内存时，buffer/cached会很快地被使用。)
    inact  # 非活跃内存大小，即被标明可回收的内存，区别于free和active -a选项时显示
    active # 活跃的内存大小 -a选项时显示
    si   # 每秒从磁盘读入虚拟内存的大小，如果这个值大于0，表示物理内存不够用或者内存泄露，要查找耗内存进程解决掉。
    so   # 每秒虚拟内存写入磁盘的大小，如果这个值大于0，同上。
    bi   # 块设备每秒接收的块数量，这里的块设备是指系统上所有的磁盘和其他块设备，默认块大小是1024byte
    bo   # 块设备每秒发送的块数量，例如读取文件，bo就要大于0。bi和bo一般都要接近0，不然就是IO过于频繁，需要调整。
    in   # 每秒CPU的中断次数，包括时间中断。in和cs这两个值越大，会看到由内核消耗的cpu时间会越多
    cs   # 每秒上下文切换次数，例如我们调用系统函数，就要进行上下文切换，线程的切换，也要进程上下文切换，这个值要越小越好，太大了，要考虑调低线程或者进程的数目,例如在apache和nginx这种web服务器中，我们一般做性能测试时会进行几千并发甚至几万并发的测试，选择web服务器的进程可以由进程或者线程的峰值一直下调，压测，直到cs到一个比较小的值，这个进程和线程数就是比较合适的值了。系统调用也是，每次调用系统函数，我们的代码就会进入内核空间，导致上下文切换，这个是很耗资源，也要尽量避免频繁调用系统函数。上下文切换次数过多表示你的CPU大部分浪费在上下文切换，导致CPU干正经事的时间少了，CPU没有充分利用。
    us   # 用户进程执行消耗cpu时间(user time)  us的值比较高时，说明用户进程消耗的cpu时间多，但是如果长期超过50%的使用，那么我们就该考虑优化程序算法或其他措施
    sy   # 系统CPU时间，如果太高，表示系统调用时间长，例如是IO操作频繁。
    id   # 空闲 CPU时间，一般来说，id + us + sy = 100,一般认为id是空闲CPU使用率，us是用户CPU使用率，sy是系统CPU使用率。
    wt   # 等待IOCPU时间。Wa过高时，说明io等待比较严重，这可能是由于磁盘大量随机访问造成的，也有可能是磁盘的带宽出现瓶颈。

    如果 r 经常大于4，且id经常少于40，表示cpu的负荷很重。
    如果 pi po 长期不等于0，表示内存不足。
    如果 b 队列经常大于3，表示io性能不好。

}
