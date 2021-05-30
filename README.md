# simple-xml: read xml to hash, write xml from lists.

Racket build-in xml decoding function is: xml->xexpr. But decoded result
is a hierrachical list, not covenient use.

Use xml->hash, you can use hash-ref to get xml element directly, or use
loop to traverse all the list elements.

Use lists->xml(lists->compact\_xml), convert recursive list to generate
xml, remove redundant format, more readable.

Chen Xiao <[chenxiao770117@gmail.com](mailto:chenxiao770117@gmail.com)>

    1 Install                         
                                      
    2 xml->hash                       
      2.1 Basic Usage                 
      2.2 Hierachy                    
      2.3 Count and List              
                                      
    3 lists->xml                      
                                      
    4 lists->xml\_content and xml-trim

```racket
 (require simple-xml) package: [simple-xml](https://pkgs.racket-lang.org/package/simple-xml)
```

## 1. Install

raco pkg install simple-xml

## 2. xml->hash

```racket
(xml->hash xml_file) -> (or/c #f hash)
  xml_file : path-string?             
```

* Load xml to hash map.

* If xml is not well formed, return \#f.

* Use hierachy to access all the nodes’s attribute and content.

* Use "’s count" suffix to get each node’s count.

* Use count to traverse list nodes.

If xml is broken, return \#f.

### 2.1. Basic Usage

xml:

```racket
<empty attr1="a1" attr2="a2">
</empty>                     
```

xml->hash:

```racket
(let ([xml_hash (xml->hash "empty.xml")])                           
  (printf "xml hash has ~a pairs.\n" (hash-count xml_hash))         
                                                                    
  (printf "empty's count: ~a\n" (hash-ref xml_hash "empty's count"))
                                                                    
  (printf "empty.attr1: [~a]\n" (hash-ref xml_hash "empty.attr1"))  
                                                                    
  (printf "empty.attr2: [~a]\n" (hash-ref xml_hash "empty.attr2"))  
                                                                    
  (printf "empty's content: [~a]\n" (hash-ref xml_hash "empty"))    
)                                                                   
                                                                    
xml hash has 4 pairs.                                               
empty's count: 1                                                    
empty.attr1: [a1]                                                   
empty.attr2: [a2]                                                   
empty's content: []                                                 
```

### 2.2. Hierachy

XML is a hierachy structure text format. So, xml->hash refect the
hierachy information. You access a node’s attribute or content, you
should give all the ancester’s name in order.

xml:

```racket
<level1>                         
  <level2>                       
    <level3 attr="a3">           
      <level4>Hello Xml!</level4>
    </level3>                    
  </level2>                      
</level1>                        
```

xml->hash:

```racket
(let ([xml_hash (xml->hash "hierachy.xml")])                                                      
  (printf "level1.level2.level3.attr: [~a]\n" (hash-ref xml_hash "level1.level2.level3.attr"))    
                                                                                                  
  (printf "level1.level2.level3.level4: [~a]\n" (hash-ref xml_hash "level1.level2.level3.level4"))
)                                                                                                 
                                                                                                  
level1.level2.level3.attr: [a3]                                                                   
level1.level2.level3.level4: [Hello Xml!]                                                         
```

### 2.3. Count and List

XML’s node can occur once or more than once. So xml->hash count all the
node. In result hash, you can get all node’s occurence count.

How? Use "’s count" suffix.

xml:

```racket
<list>                       
  <child attr="a1">c1</child>
  <child attr="a2">c2</child>
  <child attr="a3">c3</child>
</list>                      
```

xml->hash:

```racket
(let ([xml_hash (xml->hash "list.xml")])                                        
  (printf "xml hash has ~a pairs.\n" (hash-count xml_hash))                     
                                                                                
  (printf "list's count: [~a]\n" (hash-ref xml_hash "list's count"))            
                                                                                
  (printf "list.child's count: [~a]\n" (hash-ref xml_hash "list.child's count"))
                                                                                
  (printf "list.child1's content: [~a]\n" (hash-ref xml_hash "list.child1"))    
  (printf "list.child1.attr: [~a]\n" (hash-ref xml_hash "list.child1.attr"))    
                                                                                
  (printf "list.child2's content: [~a]\n" (hash-ref xml_hash "list.child2"))    
  (printf "list.child2.attr: [~a]\n" (hash-ref xml_hash "list.child2.attr"))    
                                                                                
  (printf "list.child3's content: [~a]\n" (hash-ref xml_hash "list.child3"))    
  (printf "list.child3.attr: [~a]\n" (hash-ref xml_hash "list.child3.attr")))   
                                                                                
xml hash has 8 pairs.                                                           
list's count: [1]                                                               
list.child's count: [3]                                                         
list.child1's content: [c1]                                                     
list.child1.attr: [a1]                                                          
list.child2's content: [c2]                                                     
list.child2.attr: [a2]                                                          
list.child3's content: [c3]                                                     
list.child3.attr: [a3]                                                          
```

In above example, you can use "’s count" suffix to get each node’s
occurences.

If a node’s occurs more then once, so it’s a list node. Then we can use
loop to traverse a node list.

```racket
  (let loop ([index 1])                                             
    (when (<= index (hash-ref xml_hash "list.child's count"))       
      (printf "child[~a]'s attr:[~a] and content:[~a]\n"            
              index                                                 
              (hash-ref xml_hash (format "list.child~a.attr" index))
              (hash-ref xml_hash (format "list.child~a" index)))    
      (loop (add1 index))))                                         
                                                                    
child[1]'s attr:[a1] and content:[c1]                               
child[2]'s attr:[a2] and content:[c2]                               
child[3]'s attr:[a3] and content:[c3]                               
```

## 3. lists->xml

```racket
(lists->xml xml) -> string?
  xml : list?              
```

convert lists to xml, the list should obey below rules.

1. First node of list should be a string? It represent node name.

```racket
'("H1") -> <H1/>
```

2. All the pairs represent node’s attributes.

```racket
'("H1" ("attr1" . "1") ("attr2" . "2")) -> <H1 "attr1"="1" "attr2"="2"/>
```

3. If have children, string represent its value, or, the lists
represents its children.         Node’s children should either string?
or lists?, only one of these two types.

```racket
'("H1" "haha") -> <H1>haha</H1>
                               
'("H1" ("H2" "haha")) ->       
                               
  <H1>                         
    <H2>                       
      haha                     
    </H2>                      
  </H1>                        
```

```racket
(lists->compact_xml xml) -> string?
  xml : list?                      
```

remove all the format characters.

```racket
'("H1" ("H2" "haha")) -> <H1><H2>haha</H2></H1>
```

## 4. lists->xml\_content and xml-trim

lists->xml\_content turn lists to xml without header.

xml-trim to generate compact xml.

these two function be combined together to generate the main functions.
