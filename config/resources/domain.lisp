(in-package :mu-cl-resources)

(define-resource trivia ()
    :class (s-prefix "vet:Trivia")
    :properties `(  (:type :string ,(s-prefix "vet:type"))
                    (:difficulty :string ,(s-prefix "vet:difficulty"))
                    (:question :string ,(s-prefix "vet:question"))
                    (:correct_answer :string ,(s-prefix "vet:correct_answer"))
                    (:incorrect_answer :string-set, (s-prefix "vet:incorrect_answer")))
    :has-one `  ((category :via ,(s-prefix "vet:category")
                           :as "category" ))
    :resource-base (s-url "http://qmino/data/questions/")
    :on-path "trivias")

(define-resource category ()
    :class (s-prefix "vtc:Category")
    :properties `((:name :string, (s-prefix "vtc:name")))
;    :has-many `((trivia :via ,(s-prefix "vet:category")
;                       :inverse t
;                       :as "trivias"))
    :resource-base (s-url "http://mu.semte.ch/data/question/categories/")
    :on-path "categories")