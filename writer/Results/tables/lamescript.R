

data15 = t(read.table('data_15.table', sep='\t', header=TRUE ))
data21 = t(read.table('data_21.table', sep='\t', header=TRUE ))
data03 = t(read.table('data_3.table', sep='\t', header=TRUE  ))
data07 = t(read.table('data_7.table', sep='\t', header=TRUE  ))
data18 = t(read.table('data_18.table', sep='\t', header=TRUE ))
data23 = t(read.table('data_23.table', sep='\t', header=TRUE ))
data05 = t(read.table('data_5.table', sep='\t', header=TRUE  ))
data09 = t(read.table('data_9.table', sep='\t', header=TRUE  ))


list_of_frames = list(data03,data05,data07,data09,data15,data18,data21,data23)

list_of_colors = rainbow(8)

top=1000000

png("runtimes_1E6.png", width=1366, height=768, res=120)

#plot(data23[,1], type="p", col="red", ylim=c(0,top), ylab="Runtime (Seconds)", xlab="Chromosome", axes=FALSE)

plot(data23[,1], type="p", col="red", ylim=c(0,top), ylab="", xlab="Chromosome", axes=FALSE)


names = c("3-bit","5-bit","7-bit","9-bit","15-bit","18-bit","21-bit","23-bit")
ltyes = c(1,1,1,1,1,1,1,1)
lwdes = c(2,2,2,2,2,2,2,2)

#legend(16, 1000000, names,lty=ltyes, lwd=lwdes, col=list_of_colors)
#legend(16,103, names[1:6],lty=ltyes[1:6], lwd=lwdes[1:6], col=list_of_colors[1:6])

legend(16,1000000, names[6:8],lty=ltyes[6:8], lwd=lwdes[6:8], col=list_of_colors[6:8])


ylabel <- seq(0, top, by = top/10)
xlabel <- seq(1, 23, by = 1)
xlabel2 <- seq(1,23, by = 1)
xlabel2[23] <- "X"

axis(1, at = xlabel, labels=xlabel2)
axis(2, at = ylabel, las = 1)
box()

for (f in 1:length(list_of_frames)){

    frame = list_of_frames[[f]]
    color = list_of_colors[[f]]

    for (i in 1:length(frame[1,])){
    	y <- frame[,i]
	points(y, col=color)
#	lines(y,col=color)
    }
}

dev.off()