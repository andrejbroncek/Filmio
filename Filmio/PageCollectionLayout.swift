//
//  PageCollectionLayout.swift
//  Filmio
//
//  Created by Andrej Broncek on 10/31/16.
//  Copyright © 2016 Andrej Broncek. All rights reserved.
//

import UIKit

class PageCollectionLayout: UICollectionViewFlowLayout {
  
  var lastSize: CGSize = CGSize()
  
  var scalingOffset: CGFloat      = 200
  var minimumScaleFactor: CGFloat = 0.9
  var minimumAlphaFactor: CGFloat = 0.6
  var scaleItems: Bool            = true
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  init(itemSize: CGSize) {
    super.init()
    defaultInit(itemSize)
  }
}

extension PageCollectionLayout {
  
  func defaultInit(_ itemSize: CGSize) {
    scrollDirection    = .horizontal
    minimumLineSpacing = 0
    self.itemSize      = itemSize
  }
}

extension PageCollectionLayout {
  
  override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
    super.invalidateLayout(with: context)
    
    guard let collectionView = self.collectionView else { return }
    
    if collectionView.bounds.size != lastSize {
      self.configureInset()
      self.lastSize = collectionView.bounds.size
    }
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = self.collectionView else {
      return proposedContentOffset
    }
    
    let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
    guard let layoutAttributes = self.layoutAttributesForElements(in: proposedRect) else {
      return proposedContentOffset
    }
    
    var candidateAttributes: UICollectionViewLayoutAttributes?
    let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
    
    for attributes in layoutAttributes {
      if attributes.representedElementCategory != .cell {
        continue
      }
      
      if candidateAttributes == nil {
        candidateAttributes = attributes
        continue
      }
      
      if fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
        candidateAttributes = attributes
      }
    }
    
    guard let aCandidateAttributes = candidateAttributes else {
      return proposedContentOffset
    }
    
    var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
    let offset = newOffsetX - collectionView.contentOffset.x
    
    if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
      let pageWidth = self.itemSize.width + self.minimumLineSpacing
      newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
    }
    
    return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let collectionView = self.collectionView,
      let superAttributes = super.layoutAttributesForElements(in: rect) else {
        return super.layoutAttributesForElements(in: rect)
    }
    if scaleItems == false{
      return super.layoutAttributesForElements(in: rect)
    }
    
    let contentOffset = collectionView.contentOffset
    let size = collectionView.bounds.size
    
    let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
    let visibleCenterX = visibleRect.midX
    
    guard case let newAttributesArray as [UICollectionViewLayoutAttributes] = NSArray(array: superAttributes, copyItems: true) else {
      return nil
    }
    
    newAttributesArray.forEach {
      let distanceFromCenter = visibleCenterX - $0.center.x
      let absDistanceFromCenter = min(abs(distanceFromCenter), self.scalingOffset)
      let scale = absDistanceFromCenter * (self.minimumScaleFactor - 1) / self.scalingOffset + 1
      $0.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
      
      let alpha = absDistanceFromCenter * (self.minimumAlphaFactor - 1) / self.scalingOffset + 1
      $0.alpha = alpha
    }
   
    return newAttributesArray
  }
}

extension PageCollectionLayout {
  
  func configureInset() -> Void {
    guard let collectionView = self.collectionView else {
      return
    }
    
    let inset = collectionView.bounds.size.width / 2 - itemSize.width / 2
    collectionView.contentInset  = UIEdgeInsetsMake(0, inset, 0, inset)
    collectionView.contentOffset = CGPoint(x: -inset, y: 0)
  }
}
