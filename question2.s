	AREA question2, CODE, READONLY
		ENTRY 
			ADR r0, STRING ;Getting the address of the potential palindrome so we know where to start reading
			ADR r1, EoS	;;Getting the address right after the potential palindrome so we know where to start reading from the end of the sentence/word 	
	
Loop 		CMP r0, r1 ;compare the first and second pointer to see if they are euqal. If they are that means that we have palindrome
			BEQ Palindrome ;So we can skip right to the end
Pointer1 	LDRB r3, [r0], #1 ; Else Read in the character of the first pointer 
			CMP r0, r1 ;if the pointer is now pointing at the same element as the second pointer we know its a palindrome
			BEQ Palindrome ;so are done and can skip to the buttom
			CMP r3, #65 ; else compare the character code with the lowest letter code (A-65) 
			BPL Next ;If it is greater or equal to the lowest we know it might be a letter 
			B Pointer1 ;else its not a letter so read the next character 
Next		CMP r3, #123 ;now compare the read in character code to see if it is smaller then the largest letter code (z-122)
			BPL Pointer1 ;If it is greater then the largest letter code we know that it is not a letter, so we read in the next character
			CMP r3, #97 ;else comapare it with the smallest lower case letter code (a-97)
			BPL Pointer2 ;if it is greater or equal to we have shown that it must be a lower case letter since it is greater or equal to a and smaller or equal to z 
			CMP r3, #91 ;else compare it with the largest upper case letter code (Z- 90)
			BPL Pointer1; ;If it is greater then the largest upp case letter code it cannot be a letter because it is smaller then the smallest lower case letter and bigger then the largest uppcase letter, so read the next character
			ADD r3, r3, #32 ;else it is a letter because its value is greater to equal to A and smaller or equal to Z. So now convert it to lowercase adding the lowercase code padding of 32
			
Pointer2	LDRB r4, [r1], #-1 ;read in the character of the second pointer and make the pointer point at the next character in the word (this pointer starts at back of sentence/word)
			CMP r0, r1 ;if the first and second pointer are no equal we know that it must be that the word ia a palindrome 
			BEQ Palindrome ;so skip the rest and just go to the end 
			CMP r4, #65 ;else compare the character code with the lowest letter code (A-65) 
			BPL Advance ;If it is greater or equal to the lowest we know it might be a letter 
			B Pointer2 ;else its not a letter so read the next character
Advance		CMP r4, #123 ;now compare the read in character code to see if it is smaller then the largest letter code (z-122)
			BPL Pointer2 ;If it is greater then the largest letter code we know that it is not a letter, so we read in the next character
			CMP r4, #97 ;else comapare it with the smallest lower case letter code (a-97)
			BPL BothGood ;if it is greater or equal to we have shown that it must be a lower case letter since it is greater or equal to a and smaller or equal to z 
			CMP r4, #91 ;else compare it with the largest upper case letter code (Z- 90)
			BPL Pointer2  ;If it is greater then the largest upp case letter code it cannot be a letter because it is smaller then the smallest lower case letter and bigger then the largest uppcase letter, so read the next character
			ADD r4, r4, #32 ;else it is a letter because its value is greater to equal to A and smaller or equal to Z. So now convert it to lowercase adding the lowercase code padding of 32
BothGood	CMP r3, r4 ; compare the 2 characters pointed at by the pointers
			BEQ Loop ;if they are equal the palindrome property still holds so read in the next set of the characters 
			MOV r0,#2 ;else they are not equal so they cannot be a palindrome. SO store the 2 in register 1 to indicate that
			B Finished ;And we are done so skip to button of code
			 
Palindrome	MOV r0,#1 ;If we get here that means the string was indeed a palindrome so store the 1 in register 1 to indicate that  

Finished 	B Finished ;Finished here so keep looping to avoid read error

STRING 		DCB "He lived as a devil, eh?" ;string
EoS 		DCB 0x00 ;end of string 
	END ;By Jakob Wanger, Student Number: 250950022