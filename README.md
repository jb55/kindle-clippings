
# kindle-clippings.pl

  parse kindle 'My Clippings.txt' as yaml

## Usage

    $ <"My Clippings.txt" dos2unix | ./clippings.pl > clippings.yml
    
Something more advanced

    $ <"My Clippings.txt" dos2unix | ./clippings.pl | yaml2json | jq -c '.[] | select(.type == "highlight") | .clipping'

