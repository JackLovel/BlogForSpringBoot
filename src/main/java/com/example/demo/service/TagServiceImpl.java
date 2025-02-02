package com.example.demo.service;


import com.example.demo.dao.TagRepository;
import com.example.demo.exception.NotFoundException;
import com.example.demo.po.Tag;
import com.example.demo.po.Type;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 分类接口的相关实现
 */
@Service
public class TagServiceImpl implements TagService {
   @Override
   public List<Tag> listTag(String ids) { //"1,2,3"
         return tagRepository.findAllById(convertToList(ids));
   }

   private List<Long> convertToList(String ids) {
      List<Long> list = new ArrayList<>();
      if (!"".equals(ids) && ids != null) {
         String[] idarray = ids.split(",");
         for (int i = 0; i < idarray.length; i++) {
            list.add(new Long(idarray[i]));
         }
      }

      return list;
   }

   @Autowired
   private TagRepository tagRepository;

   @Transactional
   @Override
   public Tag saveTag(Tag tag) {
      return tagRepository.save(tag);
   }

   @Transactional
   @Override
   public Tag getTag(Long id) {
      return tagRepository.findById(id).get();
   }

   @Override
   public Tag getTagByName(String name) {
      return tagRepository.findByName(name);
   }

   @Transactional
   @Override
   public Page<Tag> listTag(Pageable pageable) {
      return tagRepository.findAll(pageable);
   }

   @Override
   public List<Tag> listTag() {
      return tagRepository.findAll();
   }

   @Transactional
   @Override
   public Tag updateTag(Long id, Tag Tag) {
      Tag t = tagRepository.findById(id).get();
      if (t == null) {
         throw new NotFoundException("不存在该类型");
      }

      BeanUtils.copyProperties(Tag, t);
      return tagRepository.save(t);
   }

   @Transactional
   @Override
   public void deleteTag(Long id) {
      tagRepository.deleteById(id);
   }

   @Override
   public List<Tag> listTagTop(Integer size) {
      Sort.Order order = new Sort.Order(Sort.Direction.DESC, "blogs.size");
      Pageable pageable = PageRequest.of (0, size, Sort.by(order));
      return tagRepository.findTop(pageable);
   }
}
