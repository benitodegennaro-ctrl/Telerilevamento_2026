#le mie funzioni 
somma<-function(x,y){
  z=x+y
  return(z)
}
#differenza 
differenza<-function(x,y){
  z=x-y
  return(z)
  }
#par(mfrow
mf<-function(nrow,ncol){
  par(mfrow=c(nx,ny))
}

mf<-function(nrow=1,ncol=2){
  par(mfrow=c(nx,ny))
}

#if els
numeri<- function(x){
  if(x>0) {
    print("questo numero e positivo, nooo?")
}
  else {
    print("questo nuemro e negativo")
    }
  }

numeri<- function(x){
  if(x>0) {
    print("questo numero e positivo, nooo?")
}
  else if(x<0) {
    print("questo nuemro e negativo")
    }
    else {
      print("zero non e ne negativo ne positivo")
      }
  }


# cilci for 
loop<-function(){
  for(i in 1:10){
    print(i)
    }
     }



loop2<-function(){
  for(i in 1:10){
    op<- i*2
    print(op)
    }
     }
