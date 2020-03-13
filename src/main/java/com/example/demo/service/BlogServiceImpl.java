package com.example.demo.service;


import com.example.demo.dao.BlogRepository;
import com.example.demo.exception.NotFoundException;
import com.example.demo.po.Blog;
import com.example.demo.po.Type;
import com.example.demo.query.BlogQuery;
import com.example.demo.util.MarkdownUtils;
import com.example.demo.util.MyBeanUtils;
import com.fasterxml.jackson.databind.util.BeanUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.*;
import java.util.*;

/**
 * 标签相关的
 */
@Service
public class BlogServiceImpl  implements BlogService{

   @Override
   public Page<Blog> listBlog(Pageable pageable) {
      return blogRepository.findAll(pageable);
   }

   @Autowired
   private BlogRepository blogRepository;

   @Override
   public Blog getBlog(Long id) {
      return blogRepository.findById(id).get();
   }

   @Override
   public Page<Blog> listBlog(Pageable pageable, BlogQuery blog) {
      return blogRepository.findAll(new Specification<Blog>() {
         @Override
         public Predicate toPredicate(Root<Blog> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
            List<Predicate> predicates = new ArrayList<>();
            if (!"".equals(blog.getTitle()) && blog.getTitle() != null) {
               predicates.add(cb.like(root.<String>get("title"), "%"+blog.getTitle()+"%"));
            }
            if (blog.getTypeId() != null) {
               predicates.add(cb.equal(root.<Type>get("type"), blog.getTypeId()));
            }
            if (blog.isRecommend()) {
               predicates.add(cb.equal(root.<Boolean>get("recommend"), blog.isRecommend()));
            }
            cq.where(predicates.toArray(new Predicate[predicates.size()]));
            return null;
         }
      }, pageable);
   }

   @Transactional
   @Override
   public Blog saveBlog(Blog blog) {
      if (blog.getId() == null) {
         blog.setCreateTime(new Date());
         blog.setUpdateTime(new Date());
         blog.setViews(0);  // 设置 浏览次数为 0
      } else {
         blog.setUpdateTime(new Date());
      }

      return blogRepository.save(blog);
   }

   @Transactional
   @Override
   public Blog updateBlog(Long id, Blog blog) {
      Blog b = blogRepository.findById(id).get();
      if (b == null) {
         throw  new NotFoundException("该博客不存在");
      }
      BeanUtils.copyProperties(blog,b, MyBeanUtils.getNullPropertyNames(blog)); // 获取 blog 里有值的属性
      b.setUpdateTime(new Date());
      return blogRepository.save(b);
   }

   @Transactional
   @Override
   public void deleteBlog(Long id) {
      blogRepository.deleteById(id);
   }

   @Override
   public List<Blog> listRecommendBlogTop(Integer size) {
      Sort.Order order = new Sort.Order(Sort.Direction.DESC, "updateTime");
      Pageable pageable = PageRequest.of (0, size, Sort.by(order));
      return blogRepository.findTop(pageable);
   }

   @Override
   public Page<Blog> listBlog(String query, Pageable pageable) {
      return blogRepository.findByQuery(query, pageable);
   }

   @Transactional
   @Override
   public Blog getAndConvert(Long id) {
      Blog blog = blogRepository.findById(id).get();
      if (blog == null) {
         throw new NotFoundException("该博客不存在");
      }
      Blog b = new Blog();
      BeanUtils.copyProperties(blog, b);
      String content = b.getContent();

      b.setContent(MarkdownUtils.markdownToHtmlExtensions(content));
      blogRepository.updateViews(id);
      return b;
   }

   @Override
   public Page<Blog> listBlog(Long tagId, Pageable pageable) {
      return blogRepository.findAll(new Specification<Blog>() {
         @Override
         public Predicate toPredicate(Root<Blog> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
           Join join = root.join("tags");
           return cb.equal(join.get("id"), tagId);
         }
      }, pageable);
   }

   @Override
   public Map<String, List<Blog>> archiveBlog() {
      List<String> years = blogRepository.findGroupYear();
      Map<String, List<Blog>> map = new HashMap<>();
      for (String year: years) {
         map.put(year, blogRepository.findByYear(year));
      }

      return map;
   }

   @Override
   public Long countBlog() {
      return blogRepository.count();
   }
}
