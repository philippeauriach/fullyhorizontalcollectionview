FullyHorizontalCollectionView
=============================

An UICollectionView with horizontal scrolling and horizontal cell alignment

Developed to fulfill a personnal need: 

The statement :
--
UICollectionviewLayout with layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; gives you the following result:

          page 1             page 2
     cell 1 | cell 3 || cell 5 | cell 7
     cell 2 | cell 4 || cell 6 | cell 8
 
What I wanted to achieve:

          page 1             page 2
     cell 1 | cell 2 || cell 5 | cell 6
     cell 3 | cell 4 || cell 7 | cell 8
 

The solution :
--
A custom FullyHorizontalCollectionViewLayout. You can specify the nbColumns you want, or let it compute the number of columns in each page. For now it only works with constant itemSize.

It may fits your needs, or not, but could be helpful !

Demo:
--
![demo.gif](https://raw.githubusercontent.com/philippeauriach/fullyhorizontalcollectionview/master/demo.gif)
