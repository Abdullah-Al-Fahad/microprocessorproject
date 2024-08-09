include 'emu8086.inc'
ORG    100h
.MODEL SMALL
.STACK 100H
.DATA
distance DW ?
oil_reserve DW ? 
needed_oil DW ?
per_km_litre dw 2  
remaining_oil_after_use dw ?     
cost dw ?          
cost_after_use dw ?


.CODE
MAIN PROC  
    
    mov ax, @data
    mov ds, ax
       
start: 
printn ''
   
printn '               *****Vehicle Fuel Usage Management System*****            '                

printn ''
printn '' 
   
printn 'To begin enter the amount of oil reserve in your vehicle: '   
CALL   scan_num       ; get number in CX.
printn ''  
MOV    oil_reserve, cx            
MOV    bx,oil_reserve    

printn ''     

printn 'Enter the distance that will be covered by the vehicle: ' 
CALL   scan_num      

MOV    distance, CX


printn ''      
printn '' 
printn 'Enter fuel cost per litres in city: '

CALL   scan_num       ; get number in CX.
MOV   cost , cx               

mov ax,distance 

mul per_km_litre
mov needed_oil,ax 

mov bx, needed_oil
mov dx, oil_reserve 



cmp bx, dx
ja  error                       
            
sub dx,bx
mov remaining_oil_after_use, dx       


          
mov ax, needed_oil
mul cost 
mov bx,ax
mov cost_after_use , bx                             

printing:                              
                             
printn ''                              
printn ''                              
printn '' 
printn '' 
printn '      ******************************************************'    
printn '      *'  
printn '      *'
print  '      *        Current Oil fuel Reserve: '
mov ax, oil_reserve
call print_num
print  ' litres'   
printn '' 
print  '      *        Distance to be covered: '    
mov ax, distance
call print_num  
print  ' kilometers' 
printn ''  

print  '      *        Required fuel: '      
mov ax, needed_oil
call print_num  
print  ' litres'                                        
printn ''         
print  '      *        Fuel Cost for required fuel: '    
mov ax, cost_after_use 
call print_num
print  ' dollars'        
printn ''   
print  '      *        Fuel Reserve after usage: '    
mov ax, remaining_oil_after_use
call print_num    
print  ' litres' 
printn '' 
printn '      *'  
printn '      *' 
printn '      ******************************************************'      

jmp printing2

error:  
printn ''  
printn ''  
printn 'you do not have enough fuel to cover the distance '  
mov dx, oil_reserve
mov remaining_oil_after_use, dx    
jmp printing2    

printing2:
printn ''            
printn ''  
printn '1. Refuel'  
printn '2. Check status again'  
printn '3. Reset '  
printn '4. End '  

printn ''                   
print  'choose a option : '  

mov ah, 1
int 21h
mov bl, al
sub bl, 48         

cmp bl, 1

je refuel        

     
cmp bl, 2
je printing 

cmp bl, 3 

je start  
    
cmp bl, 4
je end

refuel: 

printn ''

printn 'Enter the amount of fuel to be added'

CALL   scan_num 

add remaining_oil_after_use, cx

jmp printing 

end:
mov ah, 4ch
int 21h


DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS  
DEFINE_PTHIS  


END