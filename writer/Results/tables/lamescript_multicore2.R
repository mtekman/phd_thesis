data1 = (read.table('data_multicore.table', sep='\t'))
data2 = (read.table('data_singlecore.table', sep='\t'))

png("runtimes_multicore_vs_singlecore.png", width=1366, height=1056, res=120)
top = 1000

# Add MultiCore
plot(data1, type="p", col="red", ylim=c(0,top), ylab="Runtime (seconds)", xlab="Bit Size", axes=FALSE)

# Add SingleCore
points(data2, col="blue")



# Multicore Regression
z = -10:200
z = z/10
lines(z, 55 + 0.0002*z ^ 4.95 , col="red" )


# Singlecore Regression
lines(z, 78 + 0.0028 * z ^ 4.7, col = "blue" )


# Legend
legend(16, 1000000, names,lty=ltyes, lwd=lwdes, col=list_of_colors)

ylabel <- seq(0, top, by = top/10)
xlabel <- seq(1, 23, by = 1)
xlabel2 <- seq(1,23, by = 1)
xlabel2[23] <- "X"

axis(1, at = xlabel, labels=xlabel2)
axis(2, at = ylabel, las = 1)
box()

legend( 3 , 1000, c( "SingleCore (4 trials)", "SingleCore Exp. Fit", "MultiCore (4 trials)", "MultiCore Exp. Fit"), lwd = 2, lty=c(NA,1,NA,1), pch=c(1,NA,1,NA), col = c("blue", "blue", "red", "red"))

dev.off()