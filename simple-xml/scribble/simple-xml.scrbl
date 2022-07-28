#lang scribble/manual

@title{Simple-Xml: read xml to hash, write xml from lists.}

Racket build-in xml decoding function is: xml->xexpr. But decoded result is a hierrachical list, not covenient use.

Use xml->hash, you can use hash-ref to get xml element directly, or use loop to traverse all the list elements.

Use lists->xml(lists->compact_xml), convert recursive list to generate xml, remove redundant format, more readable.

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

@table-of-contents[]

@section{Install}

raco pkg install simple-xml

@section{xml->hash}

@codeblock{
  (xml->hash (or/c path-string? input-port?))
}

@itemlist[
  @item{Load xml to hash map.}
  @item{If xml is not well formed, return #f.}
  @item{Use hierachy to access all the nodes's attribute and content.}
  @item{Use "'s count" suffix to get each node's count.}
  @item{Use count to traverse list nodes.}
  @item{Each node serial number from 1, serial number appended.}
]

@subsection{Basic Usage}

xml:
@codeblock{
<empty attr1="a1" attr2="a2">
</empty>
}

xml->hash:
@codeblock{
(let ([xml_hash (xml->hash "empty.xml")])
  (printf "xml hash has ~a pairs.\n" (hash-count xml_hash))

  (printf "empty's count: ~a\n" (hash-ref xml_hash "empty's count"))

  (printf "empty.attr1: [~a]\n" (hash-ref xml_hash "empty1.attr1"))

  (printf "empty.attr2: [~a]\n" (hash-ref xml_hash "empty1.attr2"))

  (printf "empty's content: [~a]\n" (hash-ref xml_hash "empty1"))
)

xml hash has 4 pairs.
empty's count: 1
empty1.attr1: [a1]
empty1.attr2: [a2]
empty1's content: []
}

@subsection{Hierachy}

XML is a hierachy structure text format. So, xml->hash refect the hierachy information.
You access a node's attribute or content, you should give all the ancester's name in order.

xml:
@codeblock{
<level1>
  <level2>
    <level3 attr="a3">
      <level4>Hello Xml!</level4>
    </level3>
  </level2>
</level1>
}

xml->hash:
@codeblock{
(let ([xml_hash (xml->hash "hierachy.xml")])
  (printf "level1.level2.level3.attr: [~a]\n" (hash-ref xml_hash "level1.level2.level3.attr"))

  (printf "level1.level2.level3.level4: [~a]\n" (hash-ref xml_hash "level1.level2.level3.level4"))
)

level1.level2.level3.attr: [a3]
level1.level2.level3.level4: [Hello Xml!]
}

@subsection{Count and List}

XML's node can occur once or more than once. So xml->hash count all the node.
In result hash, you can get all node's occurence count.

How? Use "'s count" suffix.

xml:
@codeblock{
<list>
  <child attr="a1">c1</child>
  <child attr="a2">c2</child>
  <child attr="a3">c3</child>
</list>
}

xml->hash:
@codeblock{
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
}

In above example, you can use "'s count" suffix to get each node's occurences.

If a node's occurs more then once, so it's a list node.
Then we can use loop to traverse a node list.

@codeblock{
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
}

@section{lists->xml}

@defproc[(lists->xml
              [xml list?]
              )
            string?]{
}

convert lists to xml, the list should obey below rules.

1. First node of list should be a string? or symbol? It represent node name.

    @codeblock{
     '("H1") -> <H1/>
    }

2. All the pairs represent node's attributes.

    @codeblock{
     '("H1" ("attr1" . "1") ("attr2" . "2")) -> <H1 "attr1"="1" "attr2"="2"/>
    }

3. If have children, string/symbol represent its value, or, the lists represents its children. 
        Node's children should either string? or symbol? or lists?, only one of these three types.

   @codeblock{
   '("H1" "haha") -> <H1>haha</H1>

   '("H1" ("H2" "haha")) ->

     <H1>
       <H2>
         haha
       </H2>
     </H1>
   }

@defproc[(lists->compact_xml
              [xml list?]
              )
            string?]{
}

remove all the format characters.

@codeblock{
   '("H1" ("H2" "haha")) -> <H1><H2>haha</H2></H1>
}

@section{lists->xml_content and xml-trim}

lists->xml_content turn lists to xml without header.

xml-trim to generate compact xml.

these two function be combined together to generate the main functions.
