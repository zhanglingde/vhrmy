package com.ling.vhr.orika;

import ma.glasnost.orika.impl.DefaultMapperFactory;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * @author zhangling
 * @date 2021/10/19 3:49 下午
 */
public class BookTest {


    /**
     * 对象拷贝
     */
    @Test
    public void copyUser() {
        DefaultMapperFactory mapperFactory = new DefaultMapperFactory.Builder().build();
        BookDTO bookDTO = new BookDTO().setName("三国演义").setAuthorZh("罗贯中");
        // 有多个字段一一使用 field  映射，
        // byDefault 使相同字段进行拷贝，不使用 byDefault 只拷贝默认字段
        mapperFactory.classMap(BookDTO.class, Book.class).field("authorZh", "author").byDefault().register();
        Book book = mapperFactory.getMapperFacade(BookDTO.class, Book.class).map(bookDTO);
//        Book book = mapperFactory.getMapperFacade().map(bookDTO, Book.class);
        System.out.println("book = " + book);
    }

    /**
     * 集合拷贝
     */
    @Test
    public void listCopy() {
        DefaultMapperFactory mapperFactory = new DefaultMapperFactory.Builder().build();
        List<BookDTO> books = new ArrayList<>();
        BookDTO book1 = new BookDTO().setName("三国演义").setAuthorZh("罗贯中");
        BookDTO book2 = new BookDTO().setName("西游记").setAuthorZh("吴承恩");
        BookDTO book3 = new BookDTO().setName("水浒传").setAuthorZh("施耐庵");
        books.add(book1);
        books.add(book2);
        books.add(book3);
        // 字段不同匹配
        mapperFactory.classMap(BookDTO.class,Book.class).field("authorZh","author").byDefault().register();
        List<Book> bookList = mapperFactory.getMapperFacade().mapAsList(books, Book.class);
        System.out.println(bookList);
    }

    /**
     * 对象中集合拷贝
     */
    @Test
    public void listInObjectCopy() {
        DefaultMapperFactory mapperFactory = new DefaultMapperFactory.Builder().build();
        List<BookDTO> books = new ArrayList<>();
        BookDTO book1 = new BookDTO().setName("三国演义").setAuthorZh("罗贯中");
        BookDTO book2 = new BookDTO().setName("西游记").setAuthorZh("吴承恩");
        BookDTO book3 = new BookDTO().setName("水浒传").setAuthorZh("施耐庵");
        books.add(book1);
        books.add(book2);
        books.add(book3);
        LibraryDTO libraryDTO = new LibraryDTO().setBookDTOList(books).setName("浙江图书馆");
        System.out.println("libraryDTO = " + libraryDTO);

        // 映射对象中的不同字段
        mapperFactory.classMap(LibraryDTO.class,Library.class).field("bookDTOList","books").byDefault().register();
        // 映射对象集合中的不同字段
        mapperFactory.classMap(BookDTO.class,Book.class).field("authorZh","author").byDefault().register();
        Library library = mapperFactory.getMapperFacade().map(libraryDTO, Library.class);
        System.out.println("library = " + library);
    }
}
