IMPERATIVE VS DECLARATIVE

imperative -- telling the computer exaclty how to do something
    --- more complex and more flexible, can state exactly how everything should be
    --- more verbose code, but more customizable

        var number = [1,2,3]
        var doubledNumber = [];
        for(var i =0; i < number.length; i++){
            doubledNumbers.push(numbers[i] * 2);
        }
        --> telling program exactly how to do each and every step ( how to iterate, how to push)

declarative -- telling computer what we'd like to do, leaving the "how" to library or other funcs
    --- less complex, less flexible, we "state" what we want, and get limited pre-made solutions
    --- instead of doing same things again and again, we abstract functionality & state what we want
    --- more compact and readable code

        var number = [1,2,3]
        var doubledNumber = numbers.map(function(){
            return number * 2;
        });
        ---> ONLY TELL what is main objective (double the numbers)

=================================================================================================

