package com.example.demo.service;


import com.example.demo.po.Blog;
import com.example.demo.po.Tag;
import com.example.demo.query.BlogQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
 * 标签相关的
 */
public interface BlogService {
   Blog getBlog(Long id);
   Blog getAndConvert(Long id);
   Page<Blog> listBlog(Pageable pageable, BlogQuery blog);
   Page<Blog> listBlog(Pageable pageable);
   Page<Blog> listBlog(Long tagId, Pageable pageable);
   Page<Blog> listBlog(String query, Pageable pageable);
   List<Blog> listRecommendBlogTop(Integer size);
   Blog saveBlog(Blog blog);
   Blog updateBlog(Long id, Blog blog);
   void deleteBlog(Long id);
   Map<String, List<Blog>> archiveBlog();
   Long countBlog();
}
